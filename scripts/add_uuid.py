import json
import os
from uuid import uuid4
from typing import *

def call():
    res_dir = 'resources' #os.getenv("RESOURCE_DIR")

    fish_json = _read(res_dir)
    fish_with_uuid = list(map(lambda f: {'uuid': str(uuid4()), **f} , fish_json))
    _ = _write(res_dir, fish_with_uuid)

def _read(res_dir: str) -> List[Dict]:
    with open(res_dir + "/bugs.json", encoding='utf-8') as fish_file:
        return json.load(fish_file)

def _write(res_dir: str, data: Dict) -> None:
    with open(res_dir + "/bugs_uuid.json", "w", encoding='utf-8') as out:
        json.dump(data, out, indent=2)

call()