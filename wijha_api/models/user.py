from enum import Enum
from mongoengine import Document, fields


class UserType(Enum):
    """
    Enum listing the different types of users
    """

    TOURIST = "tourist"
    GUIDE = "guide"
    ADMIN = "admin"


class User(Document):
    username = fields.StringField(required=True, max_length=15)
    password = fields.StringField(required=True)
    profile_picture = fields.StringField()
    travel_points = fields.IntField()
    user_type = fields.StringField(required=True, default="tourist")

    meta = {"collection": "User"}
