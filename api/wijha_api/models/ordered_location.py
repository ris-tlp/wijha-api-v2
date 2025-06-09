from mongoengine import Document, fields
from wijha_api.models.tour import Tour


class OrderedLocation(Document):
    name = fields.StringField(required=True)
    description = fields.StringField(required=True)
    location_fact = fields.StringField(requied=True)
    location_number = fields.IntField(required=True, default=0)
    image_url = fields.StringField(required=True)
    tour = fields.ReferenceField(Tour)
