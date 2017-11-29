require "json"

departments = JSON.parse(File.read(File.dirname(__FILE__) +  "/constants/departments.json"))

p departments.first