terraform {
  cloud {
    organization = "devopssean"
    workspaces {
      name = "prod"
    }
  }
}