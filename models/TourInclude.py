from mongoengine import Document, StringField


class TourInclude(Document):
    title = StringField(required=True)
    icon = StringField(required=True, max_length=100)
