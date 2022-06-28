resource "aws_ecr_repository" "adservice" {
  name                 = "adservice"
  image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
  }
}

resource "aws_ecr_repository" "cartservice" {
  name                 = "cartservice"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "checkoutservice" {
  name                 = "checkoutservice"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "currencyservice" {
  name                 = "currencyservice"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "emailservice" {
  name                 = "emailservice"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "frontend" {
  name                 = "frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "loadgenerator" {
  name                 = "loadgenerator"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "paymentservice" {
  name                 = "paymentservice"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "shippingservice" {
  name                 = "shippingservice"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "productcatalogservice" {
  name                 = "productcatalogservice"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "recommendationservice" {
  name                 = "recommendationservice"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "adservice" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }
  
output "cartservice" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }
  
output "checkoutservice" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }
  
output "currencyservice" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }
  
output "emailservice" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }
  
output "frontend" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }
  
output "loadgenerator" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }
  
output "paymentservice" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }
  
output "shippingservice" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }
  
output "productcatalogservice" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }
  
output "recommendationservice" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }