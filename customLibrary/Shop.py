from robot.api.deco import keyword, library
from robot.libraries.BuiltIn import BuiltIn
# this is a .py file and not a .robot file -> So if I need the SeleniumLibrary to be imported
# I can't write 'Library SeleniumLibrary, but from the constructor I need to import it
# with class BuiltIn() as shown below

#must insert annotation @library and @keyword , so robotframework understands that this file it's a library

@library
class Shop:

    def __init__(self):
        self.seleniumLib = BuiltIn().get_library_instance("SeleniumLibrary")  #now I can use the Robot keywords into a python file

    #method name will be converted to keyword name
    @keyword
    def example_custom_keyword_hello_world(self):
        print("Hello World!!!!")


    @keyword
    def add_items_to_cart_and_checkout(self, productList):
        # ${web_elements}=    Get Webelements    css:.card-title  --> this selects all the products from the webpage
        i = 1
        # to convert Robot Keywords into Python methods: SAME NAME WITH NO CAPITAL LETTERS + REPLACE SPACE WITH symbol: _
        # inside the () we must specify the locator (css or xpath..)
        # Get Webelements becomes --> get_webelements in py
        # Click Button becomes -->  click_button in py
        productsTitles = self.seleniumLib.get_webelements("css:.card-title")
        for product in productsTitles:
            if product.text in productList:
                self.seleniumLib.click_button("xpath:(//div[@class='card-footer'])["+str(i)+"]/button")
            i = i + 1

        #click on the checkout button after selecting the items
        self.seleniumLib.click_link("css:li.active a")
