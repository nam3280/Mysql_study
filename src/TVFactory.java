public class TVFactory extends Factory implements IWorkingTogether{
    TVFactory(String name, int openHour, int closeHour){
        super(name,openHour,closeHour);
    }

    @Override
    int makeProducts(char skill){
        if(skill == 'A')
            return 8 * this.getWorkingTime();
        else if(skill == 'B')
            return 5 * this.getWorkingTime();
        else if(skill == 'C')
            return 3 * this.getWorkingTime();
        else
            return this.getWorkingTime();
    }

    @Override
    public int workTogether(IWorkingTogether partner){
        return 3 * this.getWorkingTime();
    }
}
