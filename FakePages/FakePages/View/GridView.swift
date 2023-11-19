//
//  GridView.swift
//  FakePages
//
//  Created by Claudia De Luca on 19/11/23.
//

import SwiftUI
import SwiftData

struct GridView: View {
    @Environment (\.modelContext) private var context
    @Query private var texts: [DataText]
    
    var body: some View {
        
        let sortedTexts = texts.sorted(by: { $0.currentDate > $1.currentDate })
        
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
            ForEach(sortedTexts, id: \.self) { text in
                    VStack{
                        ZStack(alignment: .topLeading) {
                            Rectangle()
                                .foregroundStyle(.white)
                                .shadow(radius: 2)
                                .frame(width: 100, height: 150)
                            
                            Text(text.editedText)
                                .lineLimit(20)
                                .font(.custom("Text preview", fixedSize: 5))
                                .frame(width: 90)
                        }
                        
                        Text(text.title)
                            .font(.caption)
                        
                        var formattedDate: String {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd/MM/yy, h:mm:ss aa"
                            return dateFormatter.string(from: text.currentDate)
                        }
                        
                        Text("\(formattedDate)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                        
                    }

                
               /* VStack{
                    ZStack(alignment: .topLeading) {
                        Rectangle()
                            .foregroundStyle(.white)
                            .shadow(radius: 2)
                            .frame(width: 100, height: 150)
                        
                        Text(text.editedText)
                            .lineLimit(20)
                            .font(.custom("Text preview", fixedSize: 5))
                            .frame(width: 90)
                    }
                    
                    Text(text.title)
                        .font(.caption)
                    
                    var formattedDate: String {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd/MM/yy, h:mm:ss aa"
                        return dateFormatter.string(from: text.currentDate)
                    }
                    
                    Text("\(formattedDate)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                    
                }*/
                .contextMenu(ContextMenu(menuItems: {
                    ForEach(viewOption.contMenuOption){ contMenu in
                        if(contMenu.isDestructive == true){
                            Button(contMenu.nameOM,
                                   systemImage: contMenu.imageOM,
                                   role: .destructive,
                                   action: {
                                deleteDocument(text)
                            })
                        } else {
                            Button(){
                                print("ciao")
                            } label: {
                                Label(contMenu.nameOM, systemImage: contMenu.imageOM)
                            }
                        }
                    }
                }))
            }
        }
    }
    
    func deleteDocument(_ text: DataText) {
        context.delete(text)
    }
    
    
}

#Preview {
    GridView()
}
