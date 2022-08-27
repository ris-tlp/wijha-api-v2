# API Endpoints
Anything within `<this>` is user input.

### User
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/user/<username>/`           | Get a user by its username.                                        | `GET`            |
| `/user/`                     | Create a new user.                                                 | `POST`           |
| `/user/validate_password/`   | Validates entered password with password stored in DB.             | `POST`           |

### Category
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/category/`                 | Get all the categories.                                            | `GET`            |
| `/category/<category_title>/` | Get a category by its title.                                       | `GET`            |
| `/category/`                 | Create a new category.                                             | `POST`           |

### Tag
| Endpoint                | Description                                                             | Type             |
|-------------------------|-------------------------------------------------------------------------|------------------|
| `/tag/`                 | Get all the tags.                                                       | `GET`            |
| `/tag/<tag_title>/`      | Get a tag by its title.                                                 | `GET`            |
| `/tag/`                 | Create a new tag.                                                       | `POST`           |

### Tour Include
| Endpoint               | Description                                                              | Type             |
|------------------------|--------------------------------------------------------------------------|------------------|
| `/tour_include/`                     | Get all the TourInclude tags.                              | `GET`            |
| `/tour_include/<tour_include_title>/` | Get a TourInclude tag by its title.                        | `GET`            |
| `/tour_include/`                     | Create a new TourInclude.                                  | `POST`           |

# TODO

- User authentication

- ~~TDD (explore frameworks)~~

- ~~Password hashing~~
  
- Strongly typed with mypy

- ~~ViewSets, Routers~~

- ~~Viewable API~~
