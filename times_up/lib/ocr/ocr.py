try:
    from PIL import Image
except ImportError:
    import Image
    
import pytesseract

file = ''
pages = 11
print('creating list...')
for i in range(1,pages + 1):
    file = i
    original = pytesseract.image_to_string(Image.open(str(file) + '.tif'), lang='spa')
    s = original.replace('\n\n','\n').replace('\n\n','\n')
    text_file = open("charList.txt", "a+")
    text_file.write(s)
    text_file.write('\n')
    
text_file.close()  
print('character list created')
