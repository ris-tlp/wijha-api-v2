from botocore.exceptions import ClientError, NoCredentialsError
import base64
import boto3
import io


def upload_file(image_data, bucket_name: str, file_name: str) -> dict:
    """Uploads a blob image to an AWS s3 bucket

    Args:
        image_data (blob): Decoded b64 image
        bucket (str): Bucket name
        file_name (str): Name of file to be uploaded

    Returns:
        dict: Contains the status of upload, if successful, also contains the URL of the
              uploaded file
    """
    session = boto3.Session()
    s3 = session.resource("s3")
    bucket = s3.Bucket(bucket_name)

    try:
        image_data = base64.b64decode(image_data)
        bucket.upload_fileobj(
            Fileobj=io.BytesIO(image_data), Key=file_name, ExtraArgs={"ACL": "public-read"}
        )
        return {"status": True, "image_url": get_uploaded_url(bucket_name, file_name)}
    except FileNotFoundError:
        print("The file was not found")
        return {"status": False}
    except NoCredentialsError:
        print("Credentials not available")
        return {"status": False}
    except ClientError:
        print("Client error")
        return {"status": False}


def get_uploaded_url(bucket_name: str, file_name: str) -> str:
    """Returns the URL of the object uploaded to S3

    Args:
        bucket_name (str): S3 bucket name
        filename (str): Name of uploaded file

    Returns:
        str: Public URL of the uploaded object
    """
    bucket_location = boto3.client("s3").get_bucket_location(Bucket=bucket_name)[
        "LocationConstraint"
    ]
    return f"https://{bucket_name}.s3-{bucket_location}.amazonaws.com/{file_name}"
