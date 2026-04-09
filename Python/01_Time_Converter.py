def convert_minutes(minutes):
    hours = minutes // 60
    mins = minutes % 60

    if hours > 0 and mins > 0:
        return f"{hours} hr{'s' if hours > 1 else ''} {mins} minute{'s' if mins > 1 else ''}"
    elif hours > 0:
        return f"{hours} hr{'s' if hours > 1 else ''}"
    else:
        return f"{mins} minute{'s' if mins > 1 else ''}"


n = int(input())

for _ in range(n):
    minutes = int(input())
    print(convert_minutes(minutes))



## INPUT:
3
130
110
45

## OUTPUT:
2 hrs 10 minutes
1 hr 50 minutes
45 minutes
