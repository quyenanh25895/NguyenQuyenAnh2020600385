package paging;

import Sort.Sorter;

public interface IPageble {

    Integer getPage();
    Integer getOffset();
    Integer getLimit();
    Sorter getSorter();
}
