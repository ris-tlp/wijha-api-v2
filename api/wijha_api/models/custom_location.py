from mongoengine import Document, fields
from wijha_api.models.user import User


class CustomLocation(Document):
    name = fields.StringField(required=True)
    description = fields.StringField(required=True)
    location_fact = fields.StringField(required=True)
    location_number = fields.IntField(required=True)
    image_url = fields.StringField(required=True)
    coordinates_latitude = fields.FloatField(required=True)
    coordinates_longitude = fields.FloatField(required=True)
    guide = fields.ReferenceField(User)

    meta = {"collection": "CustomLocation"}
