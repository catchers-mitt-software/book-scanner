# Book Scanner

WORK IN PROGRESS

The idea is that this app will scan ISBN barcodes and pull up book data. It will 
not scan UPCs.

At a minimum, the book data should include the author's name, the title, 
publisher and the broad genre, but maybe not necessarily the subgenre.

I'm thinking of using the Open Library API. For information on using that API 
from a program, see the API's 
[Developer Center](https://openlibrary.org/developers/api).

For information about the ISBN format, I will be consulting 
[the ISBN.org FAQ](https://www.isbn.org/faqs_general_questions).

This program should be able to scan both ISBN-10 and ISBN-13 barcodes. What I'm 
thinking is that it will convert the older format to the newer format before 
querying the API.

Some books show both numbers. For example, *The First 100 Chinese Characters* 
from the Tuttle Language Library shows ISBN-13 978-0-8048-3830-6 _and_ ISBN-10 
0-8048-3830-5 with human-readable digits; the barcode is presumably ISBN-13. 
That book actually has two barcodes, the smaller one shows "51495" above it and 
"US $14.95" below it.

The copy of that book that I'm looking at has an additional barcode from the 
Detroit Public Library that is presumably unique to this specific copy. This 
program will have no knowledge of such barcodes.
