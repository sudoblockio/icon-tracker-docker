import requests

# NOTE this script is made because the transformer cannot connect to the extractor api for some reason
# FATAL   routines/find_missing.go:53     Routine=FindMissingBlocks - Error making job Post "http://claim-extractor:9876/api/v1/create-job": dial tcp 172.18.0.17:9876: connect: cannot assign requested address

blocks = [
  {
    "number": 273053
  },
  {
    "number": 399257
  },
  {
    "number": 462697
  },
  {
    "number": 401643
  },
  {
    "number": 405159
  },
  {
    "number": 367109
  },
  {
    "number": 429718
  },
  {
    "number": 382460
  },
  {
    "number": 449910
  },
  {
    "number": 451088
  },
  {
    "number": 389766
  }
]

for block in blocks:
    headers = {
        'accept': 'application/json',
        'Content-Type': '*/*',
    }

    data = '{\n  "end_block_number": ' + str(block["number"] + 1)+',\n  "start_block_number": ' + str(block["number"]) +'\n}'

    response = requests.post('http://localhost:9876/api/v1/create-job', headers=headers, data=data)
    print(response.status_code)
