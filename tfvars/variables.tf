 variable "instances" {
  type        = map
}
 variable "domain_name" {
  default = "aws-dev-rk.online" 
}
 variable "zone_id" {
  default = "Z04935171C92BHM9K7BG3"
}
 variable "comman_tags" {
    default = {
        project   ="expense"
        terraform = "true"
    }
}
 variable "tags" {
    type = map
}
 variable "environment" {
}
