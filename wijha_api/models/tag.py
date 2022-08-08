from mongoengine import Document, fields


class Tag(Document):
    title = fields.StringField(required=True)
    icon = fields.StringField(required=True)
    meta = {"collection": "Tag"}
