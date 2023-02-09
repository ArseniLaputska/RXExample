Hello, here is a description of this little project based on RxSwift fraemwork. The main idea of changes was to show that with help of Rx we can not only send network request but control state of our items & UI elements too and update it.

Our app look:

<img width="500" height="1200" alt="Screen" src="https://user-images.githubusercontent.com/69910183/217889308-de029164-e1ae-4c9d-b854-4dfb1b5403e3.png">

There we can see list of items, search bar and load button. All of this items are binding with help of rx framework. Let's take a more detailed look on this elements.

Take a look on our button. We binding our button to observe sequences and accept result in our model. Also here I implemented the acitivity indicator with progressHUD.
Our activity indicator following all active observable elements and showing us our progress view, in case when there is no active elements progress view is hide. So it is one of the powerful side in reactive programming that we can dynamically update our view.

![Screenshot 2023-02-09 at 8 34 10 PM](https://user-images.githubusercontent.com/69910183/217892789-364b0dc9-6c1a-45ec-9776-0ffb13964b0d.png)

<img width="500" height="1000" alt="Screen" src="https://user-images.githubusercontent.com/69910183/217891069-ffd18351-0ee9-4619-a444-12c5b8c9decb.png">

Then we can look at our search bar. Firstly what I need to mention here that is our search queary works on populated data (in this case there is no problem to create reactive search with requests, but I choosed another variant). Search bar is also binding with our data, that mean that we cannot use it until we get some data to search, which is another example how convenient we can take this with few lines of code.

We looking onto our model state and based on this we can control our search bar. To reach this we create simple "Binding" reactive extension.

![Screenshot 2023-02-09 at 8 45 09 PM](https://user-images.githubusercontent.com/69910183/217895491-aaffaae9-0529-4d80-b4b3-b62f0c17443b.png)

![Screenshot 2023-02-09 at 8 46 55 PM](https://user-images.githubusercontent.com/69910183/217895760-5133edee-a652-47e8-8a8f-9dc4373e0539.png)

And how it look in our app:

<img width="212" alt="Screenshot 2023-02-09 at 8 49 09 PM" src="https://user-images.githubusercontent.com/69910183/217896249-346b3d96-e4c9-4a4a-9065-b201514ff501.png">
->
<img width="222" alt="Screenshot 2023-02-09 at 8 49 29 PM" src="https://user-images.githubusercontent.com/69910183/217896313-ed3130b4-0591-4311-bdbc-db25e06539e6.png">

Search works perfectly ;)

<img width="500" height="1200" alt="Screen" src="https://user-images.githubusercontent.com/69910183/217891013-15c8327b-e056-43bd-be18-d04176f2b16f.png">

So more detailed you can see inside of project or just download it.
