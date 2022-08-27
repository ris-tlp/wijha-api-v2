from mongoengine import Document, fields


class Subforum(Document):
    title = fields.StringField(required=True)
    description = fields.StringField(required=True)
    image = fields.StringField(required=True)
    total_posts = fields.IntField()

    meta = {"collection": "Subforum"}
