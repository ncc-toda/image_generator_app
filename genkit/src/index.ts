// 必要なパッケージのインポート
import { vertexAI } from "@genkit-ai/vertexai";
import { genkit, z } from "genkit";
import { logger } from "genkit/logging";

// Genkit の初期化と Vertex AI プラグインの設定
const ai = genkit({ plugins: [vertexAI()] });
logger.setLogLevel("debug");

// 画像生成用の Genkit Flow を定義
export const generateImageFlow = ai.defineFlow(
  {
    name: "generateImage",
    inputSchema: z.object({
      imageDescription: z.string(), // クライアントから受け取る画像の説明文
    }),
  },
  async (input) => {
    // Imagen 3 へ送信するプロンプトの生成
    const prompt = `You are the best Japanese manga artist in the world.
      Please generate an image of ${input.imageDescription}.`;

    // Vertex AI 内の Imagen 3 による画像生成の実行
    const response = await ai.generate({
      model: `vertexai/imagen3`, // 使用モデル
      prompt: prompt, // 生成プロンプト
      config: {
        temperature: 0.7, // 生成時の創造性の度合い（0.0 - 1.0)
      },
      output: {
        format: `media`, // 出力形式を画像データに指定
      },
    });

    console.log("Response:", response);
    return response.media;
  }
);

// サーバーの起動設定
ai.startFlowServer({
  flows: [generateImageFlow], // 使用する Genkit 関数の登録
  cors: {
    origin: true,
  },
});
