locals {

  instances = {
    #core,mem,cpu frac,disk size
    "stage" = ["4","4","20","20"],
    "prod" = ["4","8","100","50"]
  }

}