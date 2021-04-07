package com.unisbadri.vaadindockerbuild.views.about;

import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.unisbadri.vaadindockerbuild.components.leafletmap.LeafletMap;
import com.vaadin.flow.router.Route;
import com.vaadin.flow.router.PageTitle;
import com.unisbadri.vaadindockerbuild.views.main.MainView;
import com.vaadin.flow.component.dependency.CssImport;

@Route(value = "about", layout = MainView.class)
@PageTitle("About")
@CssImport("./views/about/about-view.css")
public class AboutView extends VerticalLayout {

    private LeafletMap map = new LeafletMap();

    public AboutView() {
        setSizeFull();
        setPadding(false);
        map.setSizeFull();
        map.setView(55.0, 10.0, 4);
        add(map);
    }
}
