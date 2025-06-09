from mongoengine import Document, fields


class LocationActivity(Document):
    name = fields.StringField(required=True)
    description = fields.StringField(required=True)
    image_url = fields.StringField(required=True)
    city = fields.StringField(required=True)
    province = fields.StringField()

    meta = {"collection": "LocationActivity"}
