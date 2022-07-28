from mongoengine import Document, StringField


class Location(Document):
    name = StringField(required=True)
    description = StringField(required=True)
    image_url = StringField(required=True)
    province = StringField()
