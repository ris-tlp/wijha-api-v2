from mongoengine import Document, StringField


class Category(Document):
    title = StringField(required=True)
    icon = StringField(required=True, max_length=100)
