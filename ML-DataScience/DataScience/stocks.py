import csv

path = 'google_stock_data.csv'
csv_file = open(path, newline='')
reader = csv.reader(csv_file)
header = next(reader)
data = [row for row in reader]
print(header)
