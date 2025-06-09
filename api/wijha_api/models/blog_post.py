from mongoengine import Document, fields
from wijha_api.models.user import User
from wijha_api.models.tag import Tag


class BlogPost(Document):
    title = fields.StringField(required=True)
    content = fields.StringField(required=True)
    author = fields.ReferenceField(User)
    published_status = fields.BooleanField(required=True, default=False)
    image_url = fields.StringField()
    likes = fields.IntField(default=0)
    tags = fields.ListField(fields.ReferenceField(Tag))

    meta = {"collection": "BlogPost"}
