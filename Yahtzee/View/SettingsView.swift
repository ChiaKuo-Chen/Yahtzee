//
//  SettingsView.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import SwiftUI

struct SettingsView: View {
    
    // MARK - PROPERTIES
    
    @Environment(\.isPresented) var isPresented
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("active_icon") var activeAppIcon: String = "Blue"
    
    let IconOptions: [String] = ["Blue", "Blue Light", "Blue Dark",
                             "Green", "Green Light", "Green Dark",
                             "Pink", "Pink Light", "Pink Dark"]

    // THEME
    
//    let themes: [Theme] = themeData
//    @ObservedObject var theme = ThemeSettings.shared

    
    // MARK - BODY
    
    var body: some View {
        NavigationStack {
            VStack {
                // MARK - FORM
                Form {
                    
                    // MARK - SECTION 1

                
                    
                    // MARK - SECTION 2

                    Section(content: {
                        Picker(selection: $activeAppIcon,
                               content: {ForEach(IconOptions, id: \.self) { icon in
                            HStack {
                                Image(icon)
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                Spacer().frame(width: 8)
                                
                                Text(icon)
                                    .frame(alignment: .leading)
                            } //: HSTACK
                            .padding(3)
                        }} //: CONTENT
                               ,label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(Color.primary, lineWidth: 2)
                                    
                                    Image(systemName: "dice")
                                        .font(.system(size: 28, weight: .regular, design: .default))
                                        .foregroundStyle(Color.primary)
                                }
                                .frame(width:44, height: 44)
                
                                Text("App Icons".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.primary)
                            }
                        } //: LABEL
                        ) //: PICKER
                        .onChange(of: activeAppIcon) {
                            print(activeAppIcon)
                            UIApplication.shared.setAlternateIconName(activeAppIcon)
                        }
                        .scaledToFit()
                        .pickerStyle(.navigationLink)
                        .frame(alignment: .leading)
                        
                    } , header: {Text("Choose Dice.")}
                    ) //: SECTION 2
                    
                    .padding(.vertical, 3)

                    // MARK - SECTION 3
                    
                    Section(content: {
                        FormRowLinkView(
                            imageName: "githubLogo",
                            color: .black,
                            text: "GitHub",
                            link: "https://github.com/ChiaKuo-Chen"
                        )
                    } , header: {Text("Visit me on GitHub")}
                    ) //: SECTION 2
                    .padding(.vertical, 3)
                    
                    
                    // MARK - SECTION 4
                    
                    Section(content: {
                        FormRowStaticView(icon: "gear", firsrText: "Application", secondText: "Yahtzee")
                        FormRowStaticView(icon: "checkmark", firsrText: "Compatbility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firsrText: "Developer", secondText: "ChiaKuo-Chen")
                        FormRowStaticView(icon: "paintbrush", firsrText: "Designer", secondText: "ChiaKuo-Chen")
                        FormRowStaticView(icon: "document", firsrText: "Version", secondText: "3.14159")
                    }, header: {Text("About the application")}
                    ) //: SECTION 4
                    .padding(.vertical, 3)
                } //: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK - FOOTER
                
                Text("Copyright © All right reserved.\nChiaKuo-Chen")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundStyle(Color.secondary)
                
            } //: VSTACK
            .toolbar{
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                })
            } //: TOOLBAR
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
//            .background(Color("ColorBackground").ignoresSafeArea(edges: .all))
        } //: NAVIGATIONSTACK
//        .accentColor(themes[self.theme.themeSettings].themeColor)
        //.navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SettingsView()
        //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
