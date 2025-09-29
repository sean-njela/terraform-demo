terraform {
  cloud {
    organization = "devopssean"
    workspaces {
      name = "staging"
    }
  }
}