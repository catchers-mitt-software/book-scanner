# Book Scanner

WORK IN PROGRESS: In June 2026, I made some headway in the quick-and-dirty 
branch. I've gotten it to the point where you can type the digits of the ISBN-13 
and get the title of the book and the first author. Next two priorities are 
getting it to show the book's cover and enabling the camera to scan a book's 
ISBN so the user doesn't have to type it in.

Since I'm not doing proper testing in the quick and dirty branch, I don't intend 
to merge that branch to main.

----

The idea is that this app will scan ISBN barcodes and pull up book data. It will 
not scan UPCs. However, if the user does not give permission to use the phone's 
camera, this app will give the user the option of typing in the barcode. In 
which case the app should allow the user to type in the ISBN in whatever way is 
the most convenient, be it with dashes or spaces or without. Or maybe it can be 
limited to digits by using the number pad `UIKeyboardType`, in which case the 
display should give some indication of the separation of digits. If nothing 
else, it would be 3-6-5-1 for ISBN-13.

At a minimum, the book data should include the author's name, the book's title, 
publisher and the broad genre, but maybe not necessarily the subgenre.

I'm thinking of using the Open Library API. For information on using that API 
from a program, see the API's 
[Developer Center](https://openlibrary.org/developers/api). However, it appears 
to lack the genre and subgenre information that I need for a project related to 
this project.

For information about the ISBN format, I will be consulting 
[the ISBN.org FAQ](https://www.isbn.org/faqs_general_questions). For ease of 
reference, I have also started [a document](ISBN.md) in this repository with the 
details about ISBN that I consider to be the most relevant to this project.

I eventually stumbled upon the *ISBN Users' Manual* from the International ISBN 
Agency. It is listed in [the bibliography](bibliography.bib). That bibliography 
is for books about books or about the classifications of books, including  
cataloguing systems like the Dewey decimal classification, as well as for books 
about barcodes and such.

This program should be able to scan both ISBN-10 and ISBN-13 barcodes. I have 
decided that it will convert the older format to the newer format before  
querying the API. Therefore, I will not worry about validating ISBN-10 check 
digits. I reserve the right to revisit that decision later on. **April 13, 
2026.** I have decided that ISBN-10 numbers will be validated, but I have also 
changed my mind about where that validation should take place.

Some books show both numbers. For example, *The First 100 Chinese Characters* 
from the Tuttle Language Library shows ISBN-13 978-0-8048-3830-6 _and_ ISBN-10 
0-8048-3830-5 with human-readable digits; the barcode is presumably ISBN-13. 
That book actually has two barcodes, the smaller one shows "51495" above it and 
"US $14.95" below it.

The copy of that book that I'm looking at has an additional barcode from the 
Detroit Public Library that is presumably unique to that specific copy. This 
program will have no knowledge of such barcodes.
