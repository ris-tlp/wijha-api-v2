# Wijha UI Samples
![image](https://github.com/user-attachments/assets/2cf56658-c722-49df-ac71-9383514a0c1b)  

![image](https://github.com/user-attachments/assets/e1f7c446-0783-4f4a-b761-028a5e075a4f)  

![image](https://github.com/user-attachments/assets/c1d7afa3-df18-4a34-9ce1-198c1a3096db)

![image](https://github.com/user-attachments/assets/77649238-2c47-49e1-a280-35a41d30e742)


# Wijha API

## Requirements
1. AWS CLI configured with IAM credentials and sufficient policies.
2. Terraform for AWS infrastructure provisioning.
3. Docker

## Architecture
![Architecture](https://raw.githubusercontent.com/ris-tlp/wijha-api-v2/refs/heads/main/api/architecture/architecture.jpeg)


## API Endpoints
Anything within `<this>` is user input.

### Misc
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/upload-image/`             | Uploads an image to the desginated S3 bucket and returns the public URL                                        | `POST`            |

### User
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/user/<username>/`          | Get a user by its username.                                        | `GET`            |
| `/user/`                     | Create a new user.                                                 | `POST`           |
| `/user/validate_password/`   | Validates entered password with password stored in DB.             | `POST`           |

### Subforum
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/subforum/`                 | Get all the subforums.                                            | `GET`            |
| `/subforum/<subforum_title>/`| Get a subforum by its title.                                       | `GET`            |
| `/subforum/`                 | Create a new subforum.                                             | `POST`           |

### Forum Post
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/forum-post/`                 | Get all the forum posts.                                         | `GET`            |
| `/forum-post/<forum_post_title>/`| Get a forum post by its title.                                 | `GET`            |
| `/forum-post/`                 | Create a new forum post.                                         | `POST`           |

### Blog Post
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/blog-post/`                | Get all the blog posts.                                            | `GET`            |
| `/blog-post/<blog_post_title>/`| Get a blog post by its title.                                    | `GET`            |
| `/blog-post/`                 | Create a new blog post.                                         | `POST`           |

### Location
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/location/`                 | Get all the locations.                                              | `GET`            |
| `/location/<location_name>/` | Get a location by its name.                                        | `GET`            |
| `/location/`                 | Create a new location.                                             | `POST`           |

### Custom Location
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/custom-location/`                 | Get all the custom locations.                                      | `GET`            |
| `/custom-location/<location_name>/` | Get a location by its name.                                        | `GET`            |
| `/custom-location/`                 | Create a new location.                                             | `POST`           |

### Ordered Locaton
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/ordered-location/`                 | Get all the ordered locations.                             | `GET`            |
| `/ordered-location/<location_name>/` | Get an ordered location by its name.                       | `GET`            |
| `/ordered-location/`                 | Create a new ordered location.                             | `POST`           |

### Category
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/category/`                 | Get all the categories.                                            | `GET`            |
| `/category/<category_title>/` | Get a category by its title.                                       | `GET`            |
| `/category/`                 | Create a new category.                                             | `POST`           |

### Tour
| Endpoint                     | Description                                                        | Type             |
|------------------------------|--------------------------------------------------------------------|------------------|
| `/tour/`                 | Get all the tours.                                            | `GET`            |
| `/tour/<tour_name>/`     | Get a tour by its name.                                       | `GET`            |
| `/tour/`                 | Create a new tour.                                             | `POST`           |

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
