//
//  TranscriptionsView.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 18/11/2024.
//

import SwiftUI

struct TranscriptionsView: View {
    // MARK: - ViewModel
    @ObservedObject var viewModel: TranscriptionsViewModel
    
    // MARK: - Environment
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 4) {
                // Section 1 - Informations sécurisées
                Text("🔒 Ce message sous-titré est encrypté et stocké de manière sécurisée.")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "616770"))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color(hex: "FAFBFC"))
                    .cornerRadius(12)
                    .padding(.horizontal, 45)
                    .padding(.top, 24)
                    .padding(.bottom, 34)
                
                // Section 2 - Transcriptions comme conversation
                ForEach(viewModel.transcriptions.indices, id: \.self) { index in
                    let transcription = viewModel.transcriptions[index]
                    let isFirstInSeries = index == 0 || viewModel.transcriptions[index - 1].direction != transcription.direction
                    let isLastInSeries = index == viewModel.transcriptions.count - 1 || viewModel.transcriptions[index + 1].direction != transcription.direction

                    HStack {
                        if transcription.direction == .incoming {
                            bubbleView(
                                text: transcription.text,
                                color: Color(hex: "F6F8F9"),
                                alignment: .leading,
                                isLeft: true,
                                isFirstInSeries: isFirstInSeries,
                                isLastInSeries: isLastInSeries
                            )
                            Spacer()
                        } else {
                            Spacer()
                            bubbleView(
                                text: transcription.text,
                                color: Color(hex: "D6FAF2"),
                                alignment: .trailing,
                                isLeft: false,
                                isFirstInSeries: isFirstInSeries,
                                isLastInSeries: isLastInSeries
                            )
                        }
                    }
                }
            }
            .padding(.horizontal)
            .background(Color.white)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(spacing: 4) {
                    Text(viewModel.phoneNumber.formatPhoneNumber())
                        .font(Font.custom("Helvetica", size: 19))
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "13383B"))
                    
                    Text(viewModel.formattedCallDate())
                        .font(Font.custom("Helvetica", size: 14))
                        .foregroundColor(Color(hex: "616D70"))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 5)
            }
            
            // Bouton de retour personnalisé
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("back-arrow")
                        .resizable()
                        .frame(width: 13, height: 21)
                }
            }
        }
    }
    
    // MARK: - Bubble View
    @ViewBuilder
    private func bubbleView(
        text: String,
        color: Color,
        alignment: HorizontalAlignment,
        isLeft: Bool,
        isFirstInSeries: Bool,
        isLastInSeries: Bool
    ) -> some View {
        let roundedCorners: UIRectCorner = {
            if isLeft {
                if isFirstInSeries && isLastInSeries {
                    return [.topRight, .bottomRight]
                } else if isFirstInSeries {
                    return [.topRight, .bottomRight, .topLeft]
                } else if isLastInSeries {
                    return [.topRight, .bottomRight, .bottomLeft]
                } else {
                    return [.topRight, .bottomRight]
                }
            } else {
                if isFirstInSeries && isLastInSeries {
                    return [.topLeft, .bottomLeft]
                } else if isFirstInSeries {
                    return [.topLeft, .bottomLeft, .topRight]
                } else if isLastInSeries {
                    return [.topLeft, .bottomLeft, .bottomRight]
                } else {
                    return [.topLeft, .bottomLeft]
                }
            }
        }()

        Text(text)
            .font(.body)
            .padding(12)
            .foregroundColor(Color(hex: "027562"))
            .background(color)
            .cornerRadius(16, corners: roundedCorners)
            .frame(maxWidth: .infinity, alignment: alignment == .leading ? .leading : .trailing)
            .padding(alignment == .leading ? .leading : .trailing, 16)
            .padding(.horizontal, alignment == .leading ? 8 : 0)
    }
}
