# Async network request
Hello! There is a minor project, where I create simple table view with list of universities from various countries.

The main aim of this project was to implement asynchronous requests with RxSwift.
Also in process it was very curious to compare it to native-based solution with help of Async/Await.

The requests works fine and smooth:
![Simulator Screen Shot - iPhone 14 Pro - 2022-12-22 at 14 41 04](https://user-images.githubusercontent.com/69910183/209126911-93bf9c7d-7085-48c2-a955-35717f90b0e2.png)

Completion time almost equal:
RxSwift

<img width="302" alt="Screenshot 2022-12-12 at 1 34 05 AM" src="https://user-images.githubusercontent.com/69910183/209127652-993b8a0d-ca18-4a5e-a4f0-705eb281f2ed.png">

Async/Await

<img width="316" alt="Screenshot 2022-12-12 at 1 05 40 AM" src="https://user-images.githubusercontent.com/69910183/209127543-1d570ade-dbf9-47dc-a096-bb5350a5db08.png">

# RxSwift
Let's take a more detailed look on syntax under the hood and compare it with Async/Await. I'm throwing a 5 network calls which returns an array of University, after that we merge results and return a populated value.

Firstly we take a look on RxSwift. Starting with function send which is our generic request and return Observable. 

<img width="731" alt="Screenshot 2022-12-22 at 3 01 38 PM" src="https://user-images.githubusercontent.com/69910183/209130256-bac3eb16-b546-4c20-a0ef-3b1e61f277d7.png">

After that we write a getCounrty method with the name of the country as argument and return Observable array of University.

<img width="587" alt="Screenshot 2022-12-22 at 3 01 54 PM" src="https://user-images.githubusercontent.com/69910183/209130293-d316aec2-2be1-4cde-a94f-3ea291a4f4be.png">

And finally we create a func which get list of countries as parameters, inside we returns an array containing the results of mapping the given closure over the sequence’s elements and adopted into a single observable sequence.

<img width="552" alt="Screenshot 2022-12-22 at 3 09 39 PM" src="https://user-images.githubusercontent.com/69910183/209131554-d0fa581a-504e-46c2-9ae0-4fa569d52147.png">

And done! So it's 17 lines code with nice-looking syntax which allow passing a so many async requests as we want.

# Next is Async/Await.
It is native library which allow us to perfrom various async tasks. Apple introduced this only in 2021 but this feature becomes more popular every day.
So here we also started with generic method.

<img width="698" alt="Screenshot 2022-12-22 at 3 25 46 PM" src="https://user-images.githubusercontent.com/69910183/209134194-64e15186-4efd-4f95-99d8-7aed17d1687d.png">

Then we write a generic function which return us array of University.

<img width="609" alt="Screenshot 2022-12-22 at 3 27 16 PM" src="https://user-images.githubusercontent.com/69910183/209134419-8c8230c2-852e-40b0-a57b-19a71d3fb5ed.png">

And finally we create a func which get list of countries as parameters, inside creating task where we creating async requests (as much as countries we have), awaiting result, appending value nad return our model.

<img width="707" alt="Screenshot 2022-12-22 at 3 34 27 PM" src="https://user-images.githubusercontent.com/69910183/209135526-900cd66a-ae05-471a-9858-a685f2ffa74f.png">

Also not much code, only 23 lines and also fresh-looking readability.

# Conclusion
To conclusion I want to say that both methods has right to use, both of them very powerful. It is depends from so many factors where we can use this one or another implementation to network layer at all. We should care about the minimal support version of iOS in case of Async/Await.
So I think if you createing a new project and started supportiing at least from 15 version you can use Async/Await, because it is neat working native library. Also like RxSwift we can use Async/Await not only for network requests.
