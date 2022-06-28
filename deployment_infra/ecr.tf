resource "aws_ecr_repository" "adservice" {
  name                 = "adservice_ob"
  image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
  }
}

resource "aws_ecr_repository" "cartservice" {
  name                 = "cartservice_ob"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "checkoutservice" {
  name                 = "checkoutservice_ob"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "currencyservice" {
  name                 = "currencyservice_ob"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "emailservice" {
  name                 = "emailservice_ob"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "frontend" {
  name                 = "frontend_ob"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "loadgenerator" {
  name                 = "loadgenerator_ob"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "paymentservice" {
  name                 = "paymentservice_ob"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "shippingservice" {
  name                 = "shippingservice_ob"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "productcatalogservice" {
  name                 = "productcatalogservice_ob"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "recommendationservice" {
  name                 = "recommendationservice_ob"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "adservice" {
  value       = aws_ecr_repository.adservice.repository_url
  }
  
output "cartservice" {
  value       = aws_ecr_repository.cartservice.repository_url
  }
  
output "checkoutservice" {
  value       = aws_ecr_repository.checkoutservice.repository_url
  }
  
output "currencyservice" {
  value       = aws_ecr_repository.currencyservice.repository_url
  }
  
output "emailservice" {
  value       = aws_ecr_repository.currencyservice.repository_url
  }
  
output "frontend" {
  value       = aws_ecr_repository.frontend.repository_url
  }
  
output "loadgenerator" {
  value       = aws_ecr_repository.loadgenerator.repository_url
  }
  
output "paymentservice" {
  value       = aws_ecr_repository.paymentservice.repository_url
  }
  
output "shippingservice" {
  value       = aws_ecr_repository.shippingservice.repository_url
  }
  
output "productcatalogservice" {
  value       = aws_ecr_repository.productcatalogservice.repository_url
  }
  
output "recommendationservice" {
  value       = aws_ecr_repository.recommendationservice.repository_url
  }