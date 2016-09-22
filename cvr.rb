#!/usr/bin/ruby

require 'sinatra'
require 'json'

cvr_register = {}

# Add some default content to make testing faster and a bit more fun
startup_companies = {
	:cvr =>12345678,
	:name => "Company One",
	:address => "Ligusterstrædet 4",
	:country => "Denmark",
	:phoneno => 88888888 }

cvr_register[startup_companies[:cvr]] = startup_companies

get '/api/v1/companies' do
	response['Access-Control-Allow-Origin'] = "*"

	company_list = cvr_register
	content_type :json
	{ :companies => company_list.values, :response => true }.to_json
end

get '/api/v1/companies/:cvr' do |cvr|
	response['Access-Control-Allow-Origin'] = "*"
	cvr = Integer(cvr) rescue false
	if cvr_register.has_key?(cvr)
		content_type :json
		{ :company => cvr_register[cvr], :response => true }.to_json
	else
		{ :message => "CVR does not exist", :response => false }.to_json
	end
end

post '/api/v1/companies' do
	response['Access-Control-Allow-Origin'] = "*"
	company = JSON.parse(request.body.read)

	content_type :json

	cvr = 0
	name = "error"
	address = "error"
	country= "error"
	phoneno = nil
	response = ""

	#Verify cvr is a number. Cast in input and catch any errors
	cvr = Integer(company["cvr"]) rescue false
	if  cvr == false
		err = { :message => "CVR must be a number", :response => false }
		halt err
	end

	# Assert a name exist and is not the the empty string
	if company["name"] && !company["name"].empty?
		name = company["name"]
	else
		err = { :message => "Company name cannot be empty", :response => false }.to_json
		halt err
	end
	
	# Assert a address exist and is not the the empty string
	if company["address"] && !company["address"].empty?
		address = company["address"]
	else
		err = { :message => "Company address cannot be empty", :response => false }
		halt err
	end

	# Assert a country exist and is not the the empty string
	if company["country"] && !company["country"].empty?
		country = company["country"]
	else
		err = { :message => "Company country cannot be empty", :response => false }
		halt err
	end
	
	#Verify phoneno is a number or empty. Cast any input and catch the errors

	#Any missing or empty phone number is auto set no nil
	if !company["phoneno"] || company["phoneno"].nil?
		phoneno = nil
	else
	#If any var exist. It must be a number!
		phoneno = Integer(company["phoneno"]) rescue false
	end

	if  phoneno == false
		err = { :message => "Phone number is not mandatory, but must be a non-zero positiv integer", :response => false }
		halt err
	end

	cvr_register[cvr] = { :cvr => cvr, :name => name, :address => address, :country => country, :phoneno => phoneno}
	{ :message => "Company created/updated", :response => true }.to_json
end

options "/api/v1/companies" do
  response['Access-Control-Allow-Origin'] = "*"
  response['Access-Control-Allow-Methods'] = "POST, GET, OPTIONS"
  response["Access-Control-Allow-Headers"] = "origin, x-requested-with, content-type"
  "*"
end

#vim: set shiftwidth=2 tabstop=2 expandtab: :indentSize=2:tabSize=2:noTabs=true:
