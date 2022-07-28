from mongoengine import Document, StringField


class LocationActivity(Document):
    name = StringField(required=True)
    description = StringField(required=True)
    image_url = StringField(required=True)
    province = StringField()
    city = StringField(required=True)
