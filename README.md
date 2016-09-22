Get all companies
==================
GET /api/v1/companies

Get a list of all companies in the DB

Example Request:
----------------
GET /api/v1/companies HTTP/1.1

Example Response:
-----------------
HTTP/1.1 200

{ "companies":
  [
    {
      "cvr":12345678,
      "name":"name of the company"
    },
      "cvr":12345677,
      "name":"company two"
    }
  ],
  "response": true
}

Get company info
================
GET /api/v1/companies/:cvs

Get details about one company.
On error => Return response = false, see message for reason

Example Request:
----------------
GET /api/v1/companies/12345678 HTTP/1.1

Example Response:
-----------------
HTTP/1.1 200
Content-Type: application/json

{ "company" :
  {
    "cvr":12345678,
    "name":"name of the company",
    "address":"company address",
    "country":"company country",
    "phoneno":11111111
  },
  "response": true
}

Insert/update a company
=======================
POST /api/v1/companies

Creates or update company information
CVR are uniq to a company. Name isn't. Phone number optional.

On error => Return response = false, see message for reason


Example Request:
----------------
POST /api/v1/companies HTTP/1.1
Accept: application/json
Content-Type: application/json

{
  "cvr":12345678,
  "name":"name of the company",
  "address":"company address",
  "country":"company country",
  "phoneno":11111111
}

Example Response:
-----------------
HTTP/1.1 200
Content-Type: application/json

{ "message":"Company created/updated", "response":true }


