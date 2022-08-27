from mongoengine import Document, fields
from wijha_api.models.subforum import Subforum
from wijha_api.models.user import User
from wijha_api.models.tag import Tag


class ForumPost(Document):
    title = fields.StringField(required=True)
    content = fields.StringField(required=True)
    author = fields.ReferenceField(User, required=True)
    likes = fields.IntField()
    tags = fields.ListField(fields.ReferenceField(Tag))
    subforum = fields.ReferenceField(Subforum)

    meta = {"collection": "ForumPost"}
