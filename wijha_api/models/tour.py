from mongoengine import Document, fields
from wijha_api.models.user import User
from wijha_api.models.category import Category
from wijha_api.models.location import Location
from wijha_api.models.tour_include import TourInclude
from wijha_api.models.custom_location import CustomLocation


class Tour(Document):
    title = fields.StringField(required=True)
    description = fields.StringField(required=True)
    capacity = fields.IntField(required=True)
    rating = fields.FloatField()
    price = fields.FloatField()
    date = fields.DateTimeField()
    active = fields.BooleanField(default=False)
    history = fields.BooleanField(default=False)
    guide = fields.ReferenceField(User)
    province = fields.ReferenceField(Location)
    images = fields.ListField(fields.StringField())
    categories = fields.ListField(fields.ReferenceField(Category))
    locations = fields.ListField(fields.ReferenceField(CustomLocation))
    included = fields.ListField(fields.ReferenceField(TourInclude))

    meta = {"collection": "Tour"}
