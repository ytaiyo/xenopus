import csv
import pandas as pd

begin = 41941000
end = 41947500

# Open the first TSV file and read its contents
with open('L.tsv', 'r') as file1:
    reader1 = csv.DictReader(file1, delimiter='\t')
    data1 = list(reader1)

# Open the second TSV file and read its contents
with open('S.tsv', 'r') as file2:
    reader2 = csv.DictReader(file2, delimiter='\t')
    data2 = list(reader2)

# Create a list to hold the matching entries
matches = []

# Loop through each entry in the first table
for row1 in data1:
    # Loop through each entry in the second table
    for row2 in data2:
        # If the sgRNA entry in the first table matches the sgRNA entry in the second table
        if row1['sgrna_seq'] == row2['sgrna_seq']:
            # Add the matching entry to the matches list
            matches.append(row1)

filtered_data = []

for row in matches:
    # Get the start value for the current row
    start = int(row['start'])
    # Check if the start value is between start and end values
    if start >= begin and start <= end:
        # If the start value is within the desired range, add the row to the filtered data list
        filtered_data.append(row)


final = pd.DataFrame(filtered_data, columns=['start','seq','sgrna_seq','score_crisprscan','offtarget_number_all','offtarget_number_seed','offtarget_cfd_score'])
final['score_crisprscan'] = pd.to_numeric(final['score_crisprscan'])
final = final.sort_values(by=['score_crisprscan'], ascending=False)



final.to_excel("output.xlsx")
