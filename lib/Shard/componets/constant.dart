import 'dart:math';

import 'package:fl_chart/fl_chart.dart';

dynamic module1;
dynamic maxInClock;
dynamic l;
dynamic pk;
dynamic w;
dynamic lq;
dynamic p0;
dynamic row;

List randArrivalTimeList = [0];
List randServTimeList = [];
List timeServiceBegin = [0];
List timeServiceEnd = [];

List<String> eventType = [];
List customerNumber = [];
List listClock = [];
List noCustomer=[];

String module({dynamic c, dynamic k}) {
  if (c == 1) {
    if (k >= 1) {
      return 'M/M/1/K';
    } else {
      return 'M/M/1';
    }
  } else {
    if (k >= 1) {
      return 'M/M/C/K';
    } else {
      return 'M/M/C';
    }
  }
}

result(String b, lamda, meu, int c, k) {
  switch (module1) {
    case 'M/M/1':
      if (b.compareTo('L') == 0) {
        return ('${lamda / (meu - lamda)}');
      } else if (b.compareTo('Lq') == 0) {
        return ('${(lamda * lamda) / (meu * (meu - lamda))}');
      } else if (b.compareTo('W') == 0) {
        return ('${1 / (meu - lamda)}');
      } else {
        return ('${lamda / (meu * (meu - lamda))}');
      }

    case 'M/M/1/K':
      {
        if ((lamda / meu) == 1) {
          pk = 1 / (k + 1);
        } else {
          pk = pow((lamda / meu), k) *
              ((1 - (lamda / meu)) / (1 - (pow(lamda / meu, k + 1))));
        }
      }

      if (b.compareTo('L') == 0) {
        if ((lamda / meu) == 1) {
          l = k / 2;
          return l;
        } else {
          l = ((lamda / meu) *
              ((1 -
                      ((k + 1) * pow((lamda / meu), k)) +
                      k * (pow((lamda / meu), k + 1))) /
                  ((1 - (lamda / meu)) * (1 - (pow((lamda / meu), k + 1))))));
          return l;
        }
      } else if (b.compareTo('Lq') == 0) {
        lq = (l - ((lamda / meu) * (1 - pk)));
        return lq;
      } else if (b.compareTo('W') == 0) {
        w = l / (lamda * (1 - pk));
        return w;
      } else {
        return (w - (1 / meu));
      }
    case 'M/M/C':
      {
        double summation = 0;
        for (int i = 0; i < c; i++) {
          summation += pow((lamda / meu), i) / fact(i);
        }
        row = lamda / (meu * c);
        if (row < 1) {
          p0 = 1 /
              (((c * pow((lamda / meu), c)) / fact(c) * (c - (lamda / meu))) +
                  summation);
        } else {
          p0 = 1 /
              (((1 / fact(c)) *
                      (pow((lamda / meu), c)) *
                      ((c * meu) / (c * meu - lamda))) +
                  summation);
        }
      }
      if (b.compareTo('Lq') == 0) {
        lq = p0 *
            (((pow(lamda / meu, c)) * (lamda * meu)) /
                (fact(c - 1) * (pow((c * meu) - lamda, 2))));
        return lq;
      } else if (b.compareTo('L') == 0) {
        lq = p0 *
            ((pow(lamda / meu, c)) * (lamda * meu)) /
            (fact(c - 1) * (pow(c * meu - lamda, 2)));
        l = lq + (lamda / meu);
        return l;
      } else if (b.compareTo('W') == 0) {
        w = (lq / lamda) + (1 / meu);
        return w;
      } else {
        return (lq / lamda);
      }
    case 'M/M/C/K':
      var r = lamda / meu;
      row = r / c;
      {
        double summation = 0;
        for (int i = 0; i < c; i++) {
          summation += pow((lamda / meu), i) / fact(i);
        }
        if (lamda / (meu * c) != 1) {
          p0 = 1 /
              ((pow(r, c) / fact(c)) * (1 - pow((row), k - c + 1)) / (1 - row) +
                  summation);
        } else {
          p0 = 1 / (pow(r, c) / fact(c) * (k - c + 1) + summation);
        }
      }
      if (b.compareTo('Lq') == 0) {
        lq = (row *
                pow(r, c) *
                p0 *
                (1 -
                    pow(row, k - c + 1) -
                    (1 - row) * (k - c + 1) * pow(row, k - c))) /
            (fact(c) * pow(1 - row, 2));
        return lq;
      } else if (b.compareTo('L') == 0) {
        double summation1 = 0;
        {
          for (int i = 0; i < c; i++) {
            summation1 += (pow((lamda / meu), i) / fact(i)) * (c - i);
          }
        }
        lq = (row *
                pow(r, c) *
                p0 *
                (1 -
                    pow(row, k - c + 1) -
                    (1 - row) * (k - c + 1) * pow(row, k - c))) /
            (fact(c) * pow(1 - row, 2));
        l = lq + c - p0 * summation1;
        return l;
      } else if (b.compareTo('W') == 0) {
        if (k < c) {
          pk = (p0 * pow(r, k) / fact(k.round())).round();
        } else {
          pk = p0 * pow(r, k) / (fact(c) * pow(c, k - c));
        }
        var lamdad = lamda * (1 - pk);
        w = l / lamdad;
        return w;
      } else {
        var lamdad = lamda * (1 - pk);
        return lq / lamdad;
      }
    default:
      return 'null';
  }
}

fact(int fact) {
  int c = 1;
  for (int i = fact; i > 1; i--) {
    c *= i;
  }
  return c;
}

generateArrivalTimeListMM1(arrival, sem) {
  Random random1 = Random();
  randArrivalTimeList = [0];
  dynamic minn = 0;
  dynamic d;
  if (arrival > 1 / arrival) {
    d = arrival;
  } else {
    d = 1 / arrival;
  }
  dynamic maxx = (d.round() * 2) + sem + 10;
  dynamic count = (maxx / sem).round();
  maxx = count;
  for (int i = 1; i < sem; i++) {
    randArrivalTimeList.add(minn + (random1.nextInt(maxx - minn) + 1));
    minn += count;
    maxx += count;
  }
}


generateAllListsOfMM1K(arrival,service, sem,k) {
  int nCustomer=0;
  int nQueue=0;
  int pointer=0;
  Random random1 = Random();
  timeServiceEnd = [];
  randArrivalTimeList = [0];
  timeServiceBegin = [0];
  randServTimeList=[];
  randServTimeList.add(random(service, sem));
  timeServiceEnd.add(randServTimeList[0]);

  nCustomer++;
  dynamic minn = 0;
  dynamic d;
  if (arrival > 1 / arrival) {
    d = arrival;
  } else {
    d = 1 / arrival;
  }
  dynamic maxx;
  if (k==1){
     maxx = (d.round() * 4) + sem + 500;
  }
  else if(k==2||k==3){
    maxx = (d.round() * 4) + sem + 350;
  }
else{
     maxx = (d.round() * 4) + sem + 300;
  }
  dynamic count = (maxx / sem).round();
  maxx = count;
  int value;
  for (int i = 1; i < sem; i++) {
    value =minn + (random1.nextInt(maxx - minn)) + 1;
    print('value is $value');
    if(value-timeServiceEnd[pointer]>=0){ /////////////////////////////////////
      pointer++;
      randArrivalTimeList.add(value);
      if (randArrivalTimeList[i] > timeServiceEnd[i - 1]) {
        timeServiceBegin.add(randArrivalTimeList[i]);
      } else {
        timeServiceBegin.add(timeServiceEnd[i - 1]);
      }
      randServTimeList.add(random(service, sem));
      timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
      minn = value;
      maxx += count;
    }
    else{
      if(nCustomer<k){
        nCustomer++;
        nQueue++;
        randArrivalTimeList.add(value);
        if (randArrivalTimeList[i] > timeServiceEnd[i - 1]) {
          timeServiceBegin.add(randArrivalTimeList[i]);
        } else {
          timeServiceBegin.add(timeServiceEnd[i - 1]);
        }
        randServTimeList.add(random(service, sem));
        timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
        minn = value;
        maxx += count;
      }
      else{
        i--;
      }
    }

  }
}


generateAllListsOfMMC(arrival,service, sem,c) {
  int nCustomer=0;
  int nQueue=0;
  List listHereOrNot =[];
  Random random1 = Random();
  timeServiceEnd = [];
  randArrivalTimeList = [0];
  timeServiceBegin = [0];
  randServTimeList=[];
  randServTimeList.add(random(service, sem));
  timeServiceEnd.add(randServTimeList[0]);
  nCustomer++;
  listHereOrNot.add(1);
  dynamic minn = 0;

  dynamic d;
  if (arrival > (1 / arrival)) {
    d = arrival;
  } else {
    d = 1 / arrival;
  }
  dynamic maxx;
    maxx = (d.round() * 2) + sem + 10;

  dynamic count = (maxx / sem).round();
  maxx = count;
  int arrivalTimeValue;
  for (int i = 1; i < sem; i++) {
    arrivalTimeValue =minn + (random1.nextInt(maxx - minn)) + 1;
    print('value is $arrivalTimeValue');
    if(nCustomer<c){ //////
      print("iam if");
      randArrivalTimeList.add(arrivalTimeValue);
    timeServiceBegin.add(arrivalTimeValue);
      randServTimeList.add(random(service, sem));
      timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
      minn += count;
      maxx += count;
      nCustomer++;
      listHereOrNot.add(1);
    }
    else{
      for(int j=0;j<timeServiceEnd.length;j++){
        if (arrivalTimeValue>=timeServiceEnd[j]&&listHereOrNot[j]==1){
          listHereOrNot[j]==0;
          nCustomer--;
        }
      }
      if(nCustomer<c) { /////////////////////////////////////

        randArrivalTimeList.add(arrivalTimeValue);
        timeServiceBegin.add(arrivalTimeValue);
        randServTimeList.add(random(service, sem));
        timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
        minn += count;
        maxx += count;
        nCustomer++;
        listHereOrNot.add(1);
      }
      else{
       nCustomer++;
       nQueue++;
       listHereOrNot.add(1);
       dynamic min=100000000000;
       for(int j=0;j<timeServiceEnd.length;j++){
         print("i am timeServiceEnd ${timeServiceEnd[j]}");
         print("i am listHereOrNot ${listHereOrNot[j]}");
         if (timeServiceEnd[j]<=min&&listHereOrNot[j]==1){
        min=timeServiceEnd[j];
         }
       }
       randArrivalTimeList.add(arrivalTimeValue);
       timeServiceBegin.add(min);
       randServTimeList.add(random(service, sem));
       timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
       min += count;
       maxx += count;
      }
    }

  }
}


generateAllListsOfMMCK(arrival,service, sem,c,k) {
   List listHereOrNot =[];
  int nCustomer=0;
  int nQueue=0;
  int pointer=0;
  Random random1 = Random();
  timeServiceEnd = [];
  randArrivalTimeList = [0];
  timeServiceBegin = [0];
  randServTimeList=[];
  randServTimeList.add(random(service, sem));
  timeServiceEnd.add(randServTimeList[0]);
  nCustomer++;
  listHereOrNot.add(1);
  dynamic minn = 0;
  dynamic d;
  if (arrival > 1 / arrival) {
    d = arrival;
  } else {
    d = 1 / arrival;
  }
  dynamic maxx;
  if (k==1){
    maxx = (d.round() * 4) + sem + 500;
  }
  else if(k==2){
    maxx = (d.round() * 4) + sem + 350;
  }
  else if(k==3){
    maxx = (d.round() * 4) + sem + 120;
  }
  else{
    maxx = (d.round() * 4) + sem + 50;
  }
  dynamic count = (maxx / sem).round();
  maxx = count;
  int  arrivalTimeValue;;
   for (int i = 1; i < sem; i++) {
     arrivalTimeValue =minn + (random1.nextInt(maxx - minn)) + 1;
     if(arrivalTimeValue-timeServiceEnd[pointer]>=0) { /////////////////////////////////////
       pointer++;
       print('value is $arrivalTimeValue');
       if(nCustomer<c){ //////
         print("iam if");
         randArrivalTimeList.add(arrivalTimeValue);
         timeServiceBegin.add(arrivalTimeValue);
         randServTimeList.add(random(service, sem));
         timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
         minn += count;
         maxx += count;
         nCustomer++;
         listHereOrNot.add(1);
       }
       else{
         for(int j=0;j<timeServiceEnd.length;j++){
           if (arrivalTimeValue>=timeServiceEnd[j]&&listHereOrNot[j]==1){
             listHereOrNot[j]==0;
             nCustomer--;
           }
         }
         if(nCustomer<c) { /////////////////////////////////////

           randArrivalTimeList.add(arrivalTimeValue);
           timeServiceBegin.add(arrivalTimeValue);
           randServTimeList.add(random(service, sem));
           timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
           minn += count;
           maxx += count;
           nCustomer++;
           listHereOrNot.add(1);
         }
         else{
           nCustomer++;
           nQueue++;
           listHereOrNot.add(1);
           dynamic min=100000000000;
           for(int j=0;j<timeServiceEnd.length;j++){
             print("i am timeServiceEnd ${timeServiceEnd[j]}");
             print("i am listHereOrNot ${listHereOrNot[j]}");
             if (timeServiceEnd[j]<=min&&listHereOrNot[j]==1){
               min=timeServiceEnd[j];
             }
           }
           randArrivalTimeList.add(arrivalTimeValue);
           timeServiceBegin.add(min);
           randServTimeList.add(random(service, sem));
           timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
           min += count;
           maxx += count;
         }
       }



     }
     else{
       if(nCustomer<k){
         if(nCustomer<c){ //////
           print("iam if");
           randArrivalTimeList.add(arrivalTimeValue);
           timeServiceBegin.add(arrivalTimeValue);
           randServTimeList.add(random(service, sem));
           timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
           minn += count;
           maxx += count;
           nCustomer++;
           listHereOrNot.add(1);
         }
         else{
           for(int j=0;j<timeServiceEnd.length;j++){
             if (arrivalTimeValue>=timeServiceEnd[j]&&listHereOrNot[j]==1){
               listHereOrNot[j]==0;
               nCustomer--;
             }
           }
           if(nCustomer<c) { /////////////////////////////////////

             randArrivalTimeList.add(arrivalTimeValue);
             timeServiceBegin.add(arrivalTimeValue);
             randServTimeList.add(random(service, sem));
             timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
             minn += count;
             maxx += count;
             nCustomer++;
             listHereOrNot.add(1);
           }
           else{
             nCustomer++;
             nQueue++;
             listHereOrNot.add(1);
             dynamic min=100000000000;
             for(int j=0;j<timeServiceEnd.length;j++){
               print("i am timeServiceEnd ${timeServiceEnd[j]}");
               print("i am listHereOrNot ${listHereOrNot[j]}");
               if (timeServiceEnd[j]<=min&&listHereOrNot[j]==1){
                 min=timeServiceEnd[j];
               }
             }
             randArrivalTimeList.add(arrivalTimeValue);
             timeServiceBegin.add(min);
             randServTimeList.add(random(service, sem));
             timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
             min += count;
             maxx += count;
           }
         }
       }
       else{
         i--;
       }
     }



   }
}


generateServiceTimeList(service, sem) {
  randServTimeList = [];
  Random random1 = Random();
  for (int i = 0; i < sem; i++) {
    randServTimeList.add(random1.nextInt(45)+ 1);
  }
}


generateServiceTimeBeginEndList(sem) {
  timeServiceBegin = [0];
  timeServiceEnd = [];
  timeServiceEnd.add(randServTimeList[0]);
  // dynamic count=0;
  for (int i = 1; i < sem; i++) {
    // count +=randArrivalTimeList[i];
    if (randArrivalTimeList[i] > timeServiceEnd[i - 1]) {
      timeServiceBegin.add(randArrivalTimeList[i]);
    } else {
      timeServiceBegin.add(timeServiceEnd[i - 1]);
    }
    timeServiceEnd.add(timeServiceBegin[i] + randServTimeList[i]);
  }
}


generateTable(sim) {
  eventType = [];
  customerNumber = [];
  listClock = [];
  dynamic pointB=0;
  dynamic pointE=0;
  eventType.add('a');
  customerNumber.add(pointB+1);
  listClock.add(randArrivalTimeList[pointB]);
  pointB++;
  int i;
  for ( i = 0; i < 2*sim-2; i++) {
      if (timeServiceEnd[pointE] <= randArrivalTimeList[pointB]) {
        eventType.add('d');
        customerNumber.add(pointE + 1);
        listClock.add(timeServiceEnd[pointE]);
        pointE++;
      } else {
        eventType.add('a');
        customerNumber.add(pointB + 1);
        listClock.add(randArrivalTimeList[pointB]);
        pointB++;
      }
      if (pointB==sim){
        while(pointE!=sim){
          eventType.add('d');
          customerNumber.add(pointE + 1);
          listClock.add(timeServiceEnd[pointE]);
          pointE++;

        }
        return ;
      }
    }
  eventType.add('d');
  customerNumber.add(pointE+1);
  listClock.add(timeServiceEnd[pointE]);
  }

genrateTableMMC(int sim) {
    eventType = [];
    customerNumber = [];
    listClock = [];
    // eventType.add('a');
    // customerNumber.add(1);
    // listClock.add(randArrivalTimeList[0]);
    List listTakeArrival = [];
    List listTakeServeceEnd = [];
    for (int i = 0; i < sim; i++) {
      listTakeArrival.add(1);
    }
    for (int i = 0; i < sim; i++) {
      listTakeServeceEnd.add(1);
    }
    bool arrival = true;
    int i, j = 0;
    int nocust1=0,nocust2=0;
    for (int l = 0; l < 2 * sim; l++) {
      int minarr = 10000;
      int mindeb= 10000;
      for (i = 0; i < 2 * sim; i++) {


        if (i < sim) {
          if (randArrivalTimeList[i] < minarr && listTakeArrival[i] == 1) {
            minarr = randArrivalTimeList[i];
            print('i<sim min is ${minarr}' );
            arrival = true;
            nocust1 = i + 1;
          }
        }
        else {
          j = i - sim;
          if (timeServiceEnd[j] < mindeb && listTakeServeceEnd[j] == 1) {
            mindeb = timeServiceEnd[j];
            print('i> sim min is ${mindeb}' );
            arrival = false;
            nocust2 = j + 1;
          }
        }
      }
      print("l is ${l}");
      if (minarr<mindeb) {
        print("iam arrival ${nocust1} clok is ${minarr}");
        listTakeArrival[nocust1-1] = 0;
        eventType.add('a');
        customerNumber.add(nocust1);
        listClock.add(minarr);
      }
      else{
        print("iam departio ${nocust2} clok is ${mindeb}");
        listTakeServeceEnd[nocust2-1] = 0;
      eventType.add('d');
      customerNumber.add(nocust2);
      listClock.add(mindeb);}
    }
  }

maxNumber(lis) {
  int maxa = 0;
  for (int i = 0; i < lis.length; i++) {
    if (lis[i] > maxa) {
      maxa = lis[i];
    }
  }
  return maxa;
}

random(rand, int sim) {
  Random random = Random();
  double d;
  if (rand > 1 / rand) {
    d = rand;
  } else {
    d = 1 / rand;
  }
  return random.nextInt((d.round() * 2) + sim) + 1;
}
generateNoCustomer() {
  noCustomer=[];
  noCustomer.add(1);
  for (int i = 1; i < listClock.length; i++) {
    if (eventType[i]=='a'){
      noCustomer.add(noCustomer[i-1]+1);
    }
    else{
      noCustomer.add(noCustomer[i-1]-1);
    }
  }
}


List<FlSpot> getFlSpot(){

  List<FlSpot>flSpot=[];
  dynamic x=listClock[0];
  dynamic y=noCustomer[0];

  flSpot.add(
      FlSpot(
        x.toDouble(),
        y.toDouble(),
      )
  );
  for(int i=1;i<listClock.length;i++){
    if(listClock[i]-listClock[i-1]>1) {
      for (int j = listClock[i - 1] + 1; j < listClock[i]; j++) {
        x=j;
        y=noCustomer[i-1];
        flSpot.add(
            FlSpot(
              x.toDouble(),
              y.toDouble(),
            )
        );
      }
    }
    if (i!=listClock.length-1){
      if (listClock[i]==listClock[i+1])
      {
        x=listClock[i];
        int g=noCustomer[i];
        int k=noCustomer[i+1];
        int mux=max(g, k);
        if(mux!=noCustomer[i-1]){
          y=noCustomer[i-1];
          flSpot.add(
              FlSpot(
                x.toDouble(),
                y.toDouble(),
              )
          );
          y=mux;
          flSpot.add(
              FlSpot(
                x.toDouble(),
                y.toDouble(),
              )
          );
        }
        else{
          y=mux;
          flSpot.add(
              FlSpot(
                x.toDouble(),
                y.toDouble(),
              )
          );
        }
        noCustomer[i+1]=mux; //  its Modified By Sayed
        i+=1;
      }
      else
      {
        x=listClock[i];
        if(noCustomer[i]!=noCustomer[i-1]){
          y=noCustomer[i-1];
          flSpot.add(
              FlSpot(
                x.toDouble(),
                y.toDouble(),
              )
          );
          y=noCustomer[i];
          flSpot.add(
              FlSpot(
                x.toDouble(),
                y.toDouble(),
              )
          );
        }
        else{
          y=noCustomer[i];
          flSpot.add(
              FlSpot(
                x.toDouble(),
                y.toDouble(),
              )
          );
        }
      }
    }
    else
    {
      x=listClock[i];
      if(noCustomer[i]!=noCustomer[i-1]){
        y=noCustomer[i-1];
        flSpot.add(
            FlSpot(
              x.toDouble(),
              y.toDouble(),
            )
        );
        y=noCustomer[i];
        flSpot.add(
            FlSpot(
              x.toDouble(),
              y.toDouble(),
            )
        );
      }
      else{
        y=noCustomer[i];
        flSpot.add(
            FlSpot(
              x.toDouble(),
              y.toDouble(),
            )
        );
      }
    }

    // var newItems=FlSpot(
    //   x.toDouble(),
    //   y.toDouble(),
    // );
    // flSpot.add(newItems);
  }
  return flSpot;
}
yAxsis(capcity,sim)
{
  if (capcity==-1){
    return sim;
  }
  else
    return capcity+1;
}
