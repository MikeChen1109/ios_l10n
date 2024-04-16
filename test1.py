import csv
import urllib.request

GOOGLE_DOC_ID = "1eSlPqBKoNSWBbcld_m9kYByBtSpVA10VTQXFEOGP9Oc"
PATH = "../LanguegeSelector/LanguegeSelector/Localization"

print("Downloading translations...")
url = f"https://docs.google.com/spreadsheets/d/{GOOGLE_DOC_ID}/gviz/tq?tqx=out:csv"

try:
    content = urllib.request.urlopen(url).read().decode('utf-8')
except urllib.error.HTTPError as e:
    print(f"Invalid URL - {e} - {url}")
    print("Have you made sure to change the visibility?")

file = csv.reader(content.splitlines())

data = {}

for i, line in enumerate(file):
    if not line:  # Ignore blank lines
        continue

    if i == 0:  # Getting locales from header
        for locale in line:
            if not locale:  # Ignore blank cells
                continue
            data.update({locale.lower(): []})

    else:  # Loading data into memory
        for locale_index, locale in enumerate(data.keys()):
            data[locale].append([line[0], line[locale_index + 1]])

for i, locale in enumerate(data.keys()):
    path = f"{PATH}/{locale}.lproj/Localizable.strings"
    print(f"Setting data for {locale} into {path}...")

    output = ""
    for item in data[locale]:
        output += f"\"{item[0]}\" = \"{item[1]}\";\n"

    with open(path, 'w') as f:
        f.write(output)

print("... all done!")
