from mongoengine import Document, fields


class TourInclude(Document):
    title = fields.StringField(required=True)
    icon = fields.StringField(required=True)
