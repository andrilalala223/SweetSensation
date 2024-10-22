//
//  CartView.swift
//  SweetSensation
//
//  Created by D K on 18.10.2024.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cart: RealmCart?
    
    func getCart() {
        guard let cart = StorageManager.shared.carts.first else { return }
        self.cart = cart
    }
    
    func addProduct(element: RealmCartElement) {
        let product = SweetProduct(name: element.name ?? "", price: String(element.price ?? 1), description: element.description, type: "")
        StorageManager.shared.addToCart(item: product)
        getCart()
    }
    
    func removeProduct(element: RealmCartElement) {
        StorageManager.shared.removeElement(element: element)
        getCart()
    }
}

struct CartView: View {
    
    
    @Environment(\.dismiss) var dismiss

    @StateObject private var viewModel = CartViewModel()
    @State var name = ""
    @State var email = ""
    @State var phone = ""
    @State var isShown = false
    @State var alerted = false

    
    var completion: () -> ()

    
    var body: some View {
        NavigationStack {
            ZStack {
                Background(bg: "bg3")
                
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .bold()
                                .foregroundColor(.semiPurple)
                                .frame(width: 30, height: 20)
                                .padding(10)
                                .background {
                                    Circle()
                                        .foregroundColor(.white)
                                }
                        }
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    
                    StrokeText(text: "CART", width: 1.4, borderColor: .black, mainColor: .softGreen)
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .padding(.vertical, -1)
                    
                    ScrollView {
                        Image("recPinkSmall")
                            .resizable()
                            .frame(width: size().width - 50, height: size().height / 3)
                            .overlay {
                                ScrollView {
                                    if let cart = viewModel.cart, !cart.elements.isEmpty {
                                        VStack(alignment: .leading) {
                                            ForEach(cart.elements, id: \.id) { element in
                                                Rectangle()
                                                    .frame(width: size().width - 80, height: 75)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(54)
                                                    .overlay {
                                                        HStack {
                                                            Text(element.name ?? "")
                                                                .foregroundColor(.semiPurple)
                                                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                                                .frame(width: 100)
                                                            
                                                            Spacer()
                                                            
                                                            HStack {
                                                                Button {
                                                                    viewModel.removeProduct(element: element)
                                                                } label: {
                                                                    Rectangle()
                                                                        .frame(width: 25, height: 25)
                                                                        .foregroundColor(.softBlue)
                                                                        .cornerRadius(7)
                                                                        .overlay {
                                                                            Image(systemName: "minus")
                                                                                .foregroundColor(.white)
                                                                                .bold()
                                                                        }
                                                                }
                                                                
                                                                Text("\(element.quantity ?? 0)")
                                                                    .foregroundColor(.semiPurple)
                                                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                                                    .multilineTextAlignment(.center)
                                                                    .frame(width: 20)
                                                                
                                                                Button {
                                                                    viewModel.addProduct(element: element)
                                                                } label: {
                                                                    Rectangle()
                                                                        .frame(width: 25, height: 25)
                                                                        .foregroundColor(.softBlue)
                                                                        .cornerRadius(7)
                                                                        .overlay {
                                                                            Image(systemName: "plus")
                                                                                .foregroundColor(.white)
                                                                                .bold()
                                                                        }
                                                                }
                                                            }
                                                        }
                                                        .padding(.horizontal, 25)
                                                    }
                                            }
                                        }
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .frame(height: size().height / 3.4)
                            }
                        
                        Rectangle()
                            .frame(width: size().width - 60, height: 70)
                            .foregroundColor(.white)
                            .cornerRadius(54)
                            .overlay {
                                HStack {
                                    Text("TOTAL:")
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 24, weight: .black, design: .rounded))
                                    
                                    Spacer()
                                    
                                    if let cart = viewModel.cart, let value = cart.totalValue {
                                        Text(String(format: "%.2f", value))
                                            .foregroundColor(.semiPurple)
                                            .font(.system(size: 24, weight: .black, design: .rounded))
                                    }
                                    
                                    
                                        
                                }
                                .padding(.horizontal, 25)
                            }
                            .padding(.top)
                        
                        
                        Rectangle()
                            .frame(width: size().width - 60, height: 70)
                            .foregroundColor(.white)
                            .cornerRadius(54)
                            .overlay {
                                HStack {
                                    Text("NAME:")
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                    
                                    Spacer()
                                    
                                    TextField("", text: $name, prompt: Text("John"))
                                        .autocorrectionDisabled()
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                }
                                .padding(.horizontal, 25)
                            }
                            .padding(.top, 40)
                        
                        Rectangle()
                            .frame(width: size().width - 60, height: 70)
                            .foregroundColor(.white)
                            .cornerRadius(54)
                            .overlay {
                                HStack {
                                    Text("E-MAIL:")
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                    
                                    Spacer()
                                    
                                    TextField("", text: $email, prompt: Text("@mail.com"))
                                        .autocorrectionDisabled()
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                }
                                .padding(.horizontal, 25)
                            }
                        
                        Rectangle()
                            .frame(width: size().width - 60, height: 70)
                            .foregroundColor(.white)
                            .cornerRadius(54)
                            .overlay {
                                HStack {
                                    Text("PHONE:")
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                    
                                    Spacer()
                                    
                                    TextField("", text: $phone, prompt: Text("Phone number"))
                                        .autocorrectionDisabled()
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                }
                                .padding(.horizontal, 25)
                            }
                        
                        Button {
                            if name.isEmpty || email.isEmpty || phone.isEmpty {
                                alerted.toggle()
                            } else {
                                withAnimation {
                                    isShown.toggle()
                                }
                            }
                            
                        } label: {
                            Image("orderButton")
                                .resizable()
                                .frame(width: 180, height: 80)
                                .overlay {
                                    Text("ORDER")
                                        .foregroundColor(.white)
                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                }
                        }
                        .padding(.top)
                        .disabled(viewModel.cart?.elements.isEmpty ?? true)
                        .opacity((viewModel.cart?.elements.isEmpty ?? true) ? 0.5 : 1)
                    }
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                }
                
            }
        }
        .onAppear {
            viewModel.getCart()
        }
        .overlay {
            if isShown {
                ZStack {
                    CustomAlertView {
                        dismiss()
                        completion()
                    }
                }
                .frame(width: size().width, height: size().height)
                .background(.ultraThinMaterial)
            }
        }
        .alert("Please fill in all fields", isPresented: $alerted) {
            Button {
                
            } label: {
                Text("OK")
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    CartView(){}
}

struct CustomAlertView: View {
    
    @State var isShown = false
    var completion: () -> ()
    
    var body: some View {
        Rectangle()
            .frame(width: size().width - 40, height: 250)
            .cornerRadius(12)
            .blur(radius: 3)
            .foregroundColor(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.semiPurple)
                
                if !isShown {
                    ProgressView()
                        .controlSize(.large)
                        .colorMultiply(.semiPurple)
                } else {
                    VStack {
                        Text("The order message has been sent. You will be contacted at the number or email you provided.")
                            .foregroundStyle(.black)
                            .font(.system(size: 22, weight: .light))
                            .padding(.horizontal)
                        
                        Button {
                            completion()
                        } label: {
                            Text("OK")
                                .foregroundColor(.black)
                        }
                        .padding(.top)
                    }
                    
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isShown.toggle()
                }
            }
    }
}
