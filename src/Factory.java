public abstract class Factory {
    private int openHour;
    private int closeHour;
    private String name;

    Factory(String name, int openHour, int closeHour){
        this.name = name;
        this.openHour = openHour;
        this.closeHour = closeHour;
    }

    public String getFactoryName(){
        return this.name;
    }

    int getWorkingTime(){
        return this.closeHour - this.openHour;
    }

    abstract int makeProducts(char skill);
}
