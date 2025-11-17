from robot.api.deco import keyword, library

#must insert annotation @library and @keyword , so robotframework understands that this file it's a library

@library
class Shop:

    # def __init__(self):   --> constructor of Shop class (but we don't need it)

    #method name will be converted to keyword name
    @keyword
    def example_custom_keyword_hello_world(self):
        print("Hello World!!!!")