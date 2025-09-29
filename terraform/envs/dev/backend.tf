terraform {
  cloud {
    organization = "devopssean"
    workspaces {
      name = "dev"
    }
  }
}