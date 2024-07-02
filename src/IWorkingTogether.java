public interface IWorkingTogether {
    int workTogether(IWorkingTogether partner);

    default String partnerName(IWorkingTogether partner){
        return ((Factory)partner).getFactoryName();
    }
}
