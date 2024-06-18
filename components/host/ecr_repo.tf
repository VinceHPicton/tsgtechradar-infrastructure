resource "aws_ecr_repository" "frontend" {
  name                 = "tsgtechradarfrontend"
  image_tag_mutability = "IMMUTABLE"
   image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "backend" {
  name                 = "tsgtechradarbackend"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}
