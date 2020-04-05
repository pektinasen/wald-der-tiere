import csv
import functools
import requests
from bs4 import BeautifulSoup as bs
from typing import *
import os

def foo():
    html_doc = get_file()
    write_file(html_doc)
    data_dict = parse_to_dict(html_doc)
    # save_pickle()
    # write_csv(data)

def get_file() -> Optional[str]:
    file_name = "fische.html"
    
    if os.path.exists(file_name):
        with open(file_name) as f:
            try:
                html_doc = f.read()
            except:
                html_doc = None
    else:
        html_doc = download()

    return html_doc


def download() -> str:
    r = requests.get("https://animalcrossingwiki.de/acnh/fische")
    return r.text

def parse_to_dict(html_doc: str) -> Dict:
    soup = bs(html_doc, 'html.parser')
    thead  = soup.select('.desktoponly thead')[0].find_all("th")
    ["Bild", "Name", "Monate", "Uhrzeit", "Ort", "Preise", "Fangspruch"]
    
    tbody = soup.find("div", class_="desktoponly").find("table").thead.next_sibling.next_sibling
    print(tbody.prettify())

    return {}

def save_pickle():
    pass

def write_csv():
    pass

def write_file(text: str) -> None:
    f = open("fische.html", "w")
    f.write(text)
    f.close()
