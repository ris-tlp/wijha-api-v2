from mongoengine import Document, fields


class Location(Document):
    name = fields.StringField(required=True)
    description = fields.StringField(required=True)
    image_url = fields.StringField(required=True)
    province = fields.StringField()
