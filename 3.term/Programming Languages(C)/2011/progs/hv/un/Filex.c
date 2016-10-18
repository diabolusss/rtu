
//
//  File.c
//  http://developer.apple.com/rss/com.apple.adc.documentation.AppleiPhone5_0.atom
//
//  Created by Denis on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <time.h>

int main (){
    char st[255];
	char lastString[255];
    int countPerLine=0;
    int lines = 0;
    int i=0;
    int ii=0;
    int spaceCount = 0;
    int spaceCountPerOneBkeak=0;
    int sillyFuck=0;
    char temp[255];
    fgets(st, sizeof(st), stdin);
    fflush(stdin);
    printf("%d\n", (int)strlen(st));

    scanf("%d", &countPerLine);
    lines = (int)strlen(st)/countPerLine;
    for (i=0; i<lines; i++) {
        for (ii=0; ii<countPerLine; ii++) {
            printf("%c", st[i*countPerLine+ii]);
        }
        printf("\n");
    }
    i = (i-1)*countPerLine+ii;
    sprintf(lastString, "%.*s", (int)strlen(st)-i, st+i);
    lastString[strlen(lastString)-1] = '\0';


    for (i=1; i<strlen(lastString); i++) {
        if (lastString[i]==' ') {
            spaceCount++;
        }
    }
    printf("line length %d", (int)strlen(lastString));
    printf("space count %d", spaceCount);
    if (spaceCount!=0) {
        spaceCountPerOneBkeak = (int)((countPerLine - strlen(lastString))/(spaceCount+1));
        printf("spacecountperone break %d\n", spaceCountPerOneBkeak);
        for (i=0; i<strlen(lastString); i++) {//possible error area. countperline>strlen(lastString)!
            temp[sillyFuck++]=lastString[i];
            if (lastString[i]==' ') {
                for (ii=0; ii<spaceCountPerOneBkeak+1; ii++) {
                    temp[sillyFuck++]=' ';
//                    sillyFuck++;
                }
                sillyFuck --;
//                sillyFuck--;
            }
//            sillyFuck++;
        }
    }
    printf("%s\n",temp);

    return 0;
}
