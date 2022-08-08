from mongoengine import Document, fields


class Category(Document):
    title = fields.StringField(required=True)
    icon = fields.StringField(required=True)

    meta = {"collection": "Category"}
