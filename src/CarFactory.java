public class CarFactory extends Factory implements IWorkingTogether{
    CarFactory(String name, int openHour, int closeHour){
        super(name,openHour,closeHour);
    }

    @Override
    int makeProducts(char skill){
        if(skill == 'A')
            return 3 * this.getWorkingTime();
        else if(skill == 'B')
            return 2 * this.getWorkingTime();
        else if(skill == 'C')
            return this.getWorkingTime();
        else
            return 0;
    }

    @Override
    public int workTogether(IWorkingTogether partner){
        return 2 * this.getWorkingTime();
    }
}
